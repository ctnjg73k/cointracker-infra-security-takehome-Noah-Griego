VALID_API_KEYS = {"test-secret", "admin-secret"}
def is_valid_api_key(x_api_key: str):
    # Do not modify this function. Assume it is correct/secure. Use it as is. The actual implmentation would have more complexity.  
    return x_api_key in VALID_API_KEYS

def is_admin(x_api_key: str):
    # Do not modify this function. Assume it is correct/secure. Use it as is. The actual implmentation would have more complexity.  
    return x_api_key in VALID_API_KEYS and x_api_key == "admin-secret"


### Implement any other auth wrappers below here.