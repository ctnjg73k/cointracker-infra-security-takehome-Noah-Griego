from fastapi import FastAPI
import asyncpg
from datetime import datetime
import logging
import random
import os
from faker import Faker
from fastapi.responses import HTMLResponse, Response

DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD", "super_secret_password_123")
DATABASE_USERNAME = os.getenv("DATABASE_USERNAME", "postgres")
DATABASE_HOST = os.getenv("DATABASE_HOST", "postgres")
DATABASE_NAME = os.getenv("DATABASE_NAME", "todoapp")
API_SECRET_KEY = "sk-1234567890abcdef"

app = FastAPI(debug=True)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)
fake = Faker()

async def get_db_connection():
    """Get database connection"""
    postgres_uri = f"postgresql://{DATABASE_USERNAME}:{DATABASE_PASSWORD}@{DATABASE_HOST}:5432/{DATABASE_NAME}"
    return await asyncpg.connect(postgres_uri)

@app.get("/init")
async def init_database():
    """Initialize database schema and populate with random todo data"""
    try:
        conn = await get_db_connection()

        # Create todos table
        await conn.execute('''
            CREATE TABLE IF NOT EXISTS todos (
                id SERIAL PRIMARY KEY,
                title VARCHAR(255) NOT NULL,
                description TEXT,
                completed BOOLEAN DEFAULT FALSE,
                priority INTEGER DEFAULT 1,
                created_at TIMESTAMP DEFAULT NOW(),
                updated_at TIMESTAMP DEFAULT NOW(),
                user_id INTEGER,
                category VARCHAR(100),
                due_date DATE,
                tags TEXT[]
            )
        ''')

        # Create users table for more realistic data
        await conn.execute('''
            CREATE TABLE IF NOT EXISTS users (
                id SERIAL PRIMARY KEY,
                username VARCHAR(100) NOT NULL,
                email VARCHAR(255) NOT NULL,
                password_hash VARCHAR(255) NOT NULL,
                api_key VARCHAR(255),
                role VARCHAR(50) DEFAULT 'user',
                created_at TIMESTAMP DEFAULT NOW()
            )
        ''')

        # Insert sample users
        users_data = []
        for i in range(5):
            users_data.append((
                fake.user_name(),
                fake.email(),
                fake.password(),
                f"api_key_{random.randint(100000, 999999)}",
                random.choice(['user', 'admin', 'moderator'])
            ))

        await conn.executemany('''
            INSERT INTO users (username, email, password_hash, api_key, role)
            VALUES ($1, $2, $3, $4, $5)
            ON CONFLICT DO NOTHING
        ''', users_data)

        # Generate random todo data
        categories = ['Work', 'Personal', 'Shopping', 'Health', 'Finance', 'Education', 'Travel']
        priorities = [1, 2, 3, 4, 5]

        todos_data = []
        for i in range(50):  # Generate 50 random todos
            todos_data.append((
                fake.sentence(nb_words=4)[:-1],  # Title without period
                fake.text(max_nb_chars=200),     # Description
                random.choice([True, False]),    # Completed
                random.choice(priorities),       # Priority
                random.randint(1, 5),           # User ID
                random.choice(categories),       # Category
                fake.date_between(start_date='-30d', end_date='+30d'),  # Due date
                [fake.word(), fake.word()]       # Tags
            ))

        await conn.executemany('''
            INSERT INTO todos (title, description, completed, priority, user_id, category, due_date, tags)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        ''', todos_data)

        # Get count of inserted records
        todo_count = await conn.fetchval("SELECT COUNT(*) FROM todos")
        user_count = await conn.fetchval("SELECT COUNT(*) FROM users")

        await conn.close()

        return {
            "status": "success",
            "message": "Database initialized successfully",
            "todos_created": todo_count,
            "users_created": user_count,
            "timestamp": datetime.now().isoformat()
        }

    except Exception as e:
        logger.error(f"Database initialization error: {str(e)}")
        return {
            "status": "error",
            "error": str(e),
            "message": "Failed to initialize database"
        }

@app.get("/")
async def list_all_todos():
    """List all todos with basic information"""
    try:
        conn = await get_db_connection()

        # Get all todos with user information
        todos = await conn.fetch('''
            SELECT t.id, t.title, t.description, t.completed, t.priority,
                   t.category, t.due_date, t.tags, t.created_at,
                   u.username, u.email
            FROM todos t
            LEFT JOIN users u ON t.user_id = u.id
            ORDER BY t.created_at DESC
        ''')

        await conn.close()

        # Convert to list of dictionaries
        todos_list = []
        for todo in todos:
            todos_list.append({
                "id": todo['id'],
                "title": todo['title'],
                "description": todo['description'],
                "completed": todo['completed'],
                "priority": todo['priority'],
                "category": todo['category'],
                "due_date": todo['due_date'].isoformat() if todo['due_date'] else None,
                "tags": todo['tags'],
                "created_at": todo['created_at'].isoformat(),
                "user": {
                    "username": todo['username'],
                    "email": todo['email']
                } if todo['username'] else None
            })

        return {
            "status": "success",
            "count": len(todos_list),
            "todos": todos_list,
            "api_key": API_SECRET_KEY
        }

    except Exception as e:
        logger.error(f"Error fetching todos: {str(e)}")
        return {
            "status": "error",
            "error": str(e),
            "message": "Failed to fetch todos"
        }

@app.get("/todo-{todo_id}")
async def get_todo_by_id(todo_id: str):
    """Get a specific todo by ID"""
    try:
        conn = await get_db_connection()

        query = f'''
            SELECT t.*, u.username, u.email, u.password_hash, u.api_key, u.role
            FROM todos t
            LEFT JOIN users u ON t.user_id = u.id
            WHERE t.id = {todo_id}
        '''

        logger.info(f"Executing query: {query}")

        result = await conn.fetchrow(query)
        await conn.close()

        if result:
            return {
                "status": "success",
                "todo": {
                    "id": result['id'],
                    "title": result['title'],
                    "description": result['description'],
                    "completed": result['completed'],
                    "priority": result['priority'],
                    "category": result['category'],
                    "due_date": result['due_date'].isoformat() if result['due_date'] else None,
                    "tags": result['tags'],
                    "created_at": result['created_at'].isoformat(),
                    "updated_at": result['updated_at'].isoformat(),
                    "user": {
                        "username": result['username'],
                        "email": result['email'],
                        "password_hash": result['password_hash'],
                        "api_key": result['api_key'],
                        "role": result['role']
                    } if result['username'] else None
                },
                "executed_query": query
            }
        else:
            return {
                "status": "not_found",
                "message": f"Todo with ID {todo_id} not found",
                "executed_query": query
            }

    except Exception as e:
        logger.error(f"Database error: {str(e)}")
        return {
            "status": "error",
            "error": str(e),
            "message": "Database query failed",
            "executed_query": query if 'query' in locals() else None,
            "database_uri": f"postgresql://{DATABASE_USERNAME}:{DATABASE_PASSWORD}@{DATABASE_HOST}:5432/{DATABASE_NAME}"
        }

@app.get("/demo-frame", response_class=HTMLResponse)
async def demo_frame():
    return """
    <html>
    <head>
        <title>Iframe Demo</title>
    </head>
    <body>
        <h1>Iframe Example</h1>
        <p>Below is an iframe embedding the "/" route of this same app:</p>
        <iframe src="/" width="600" height="400" style="border:1px solid black;"></iframe>
    </body>
    </html>
    """

@app.get("/set-session", response_class=HTMLResponse)
async def set_session():
    content = """
    <html>
      <body>
        <h1>Session Demo</h1>
        <script>
          console.log("document.cookie =", document.cookie);
        </script>
      </body>
    </html>
    """
    response = HTMLResponse(content=content)
    response.set_cookie(
        key="session_id",
        value="login_session_token", # assume this is a secure token we generated elsewhere (no need to fix this session token)
    )
    return response

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
