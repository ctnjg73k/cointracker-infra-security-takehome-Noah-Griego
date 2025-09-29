# security-take-home-assignment

## What is in the project
- Kubernetes Cluster
- Database
- FastAPI Todo application

## What should be done
- [ ] Fix security vulnerabilities in the code

## How to run

### Running the app
```bash
cd hello-world-app
docker compose up
```


### Infrastructure Setup
```
make kubernetes.init
make kubernetes.plan
make kubernetes.apply
make database.init
make database.plan
make database.apply
```

### Running Tests with Docker Compose

To run the application tests using Docker Compose:

1. **Start the required services** (PostgreSQL and Redis):
   ```bash
   cd hello-world-app
   docker compose up -d postgres redis
   ```

2. **Run the tests**:
   ```bash
   docker compose run --rm app sh -c "PYTHONPATH=. pytest test_suite.py -v"
   ```

3. **Clean up** (optional):
   ```bash
   docker compose down
   ```

**Note**: The tests require Python 3.13+ and updated dependencies. The Docker setup automatically handles the correct Python version and dependency installation.
