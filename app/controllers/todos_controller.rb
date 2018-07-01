class TodosController < ApplicationController
  
  def index
    @todos = Todo.all.order(due_date: :asc)  
  end

  def new
    @todo = Todo.new
    
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save 
      
      flash[:notice] = "Success to create a new todo"
      redirect_to todos_path
    else
      
      render :action => :new
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def edit
    @todo = Todo.find(params[:id])
    

    
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)

      redirect_to todos_url 
    else 
      render :edit
    end
  end

  def destroy
    
    @todo=Todo.find(params[:id])

 

    if @todo.can_destroy? 
        @todo.destroy
        redirect_to todos_url

    else
      flash[:alert] = "The task has expired,cannot be deleted."
        redirect_to todos_url
    end
    
  end

  private

  def todo_params
    params.require(:todo).permit(:name, :due_date, :note)   
  end

end
