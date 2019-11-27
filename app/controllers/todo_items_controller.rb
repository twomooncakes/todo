class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]

  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    #redirects to todolist path
    redirect_to @todo_list
  end

  def destroy
    if @todo_item.destroy
      flash[:success] = "Todo List item was deleted"
    else
      flash[:error] = "Todo List item could not be deleted"
    end
    redirect_to @todo_list
  end

  def complete
    @todo_item.toggle_completion
    if @todo_item.completed?
      redirect_to @todo_list, notice: "Todo item completed!"
    else
      redirect_to @todo_list, notice: "Todo item undone!"
    end
  end

  private
  #setting todo list
  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end
  #setting todo items
  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end
  def todo_item_params
    params[:todo_item].permit(:content)
  end

end
