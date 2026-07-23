from fastapi import FastAPI , HTTPException
from pydantic import BaseModel
from typing import List , Optional

app = FastAPI()

# Data Model
class Todo(BaseModel):
    id: int
    title: str
    isDone: bool = False

# Database in-memory
todos =  [
    {"id": 1, "title" : "Buy groceries", "isDone" : False}
]

# wellcome route
@app.get("/")
def home():
    return {"message": "welcome to my Todo API/ Go to /docs to test it."}

# REAd: Get All todos
@app.get("/todos")
def get_todos():
    return todos
# Create : Add  a new todo
@app.post("/todos")
def add_todo(todo: Todo):
    todos.append(todo.dict())
    return {"message": "Todo added!"}
# Update : Edit a todo
@app.put("/todos/{id}")
def update_todo(id: int, todo: Todo):
    for i, t in enumerate(todos):
        if t["id"] == id:
             todos[i] = todo.dict()
             return {"message": "Todo updated!"}
        raise HTTPException(status_code=404, detail="Todo not found")
# Delete Remove a todo
@app.delete("/todo/{id}")
def delete_todo(id:int):
    global todos
    todos = [t for t in todos if t["id"] != id]
    return {"message" : "Todo deleted"}
    
