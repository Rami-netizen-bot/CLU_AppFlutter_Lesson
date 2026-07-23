import jwt
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer

# This tells FastAPI where the token comes from. 
# The tokenUrl is only needed if you are using FastAPI's built-in Swagger UI to log in.
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="api/v1/auth/login")

# These must match exactly how you created the token
SECRET_KEY = "your-super-secret-key-do-not-hardcode-in-production"
ALGORITHM = "HS256"

# This is your Dependency function
async def get_current_user_id(token: str = Depends(oauth2_scheme)) -> int:
    try:
        # Decode the token
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        
        # Extract the user ID (usually stored in the "sub" standard claim)
        user_id: str = payload.get("sub")
        
        if user_id is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Could not validate credentials",
            )
        
        # Return the extracted ID
        return int(user_id)
        
    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token has expired",
        )
    except jwt.InvalidTokenError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token",
        )