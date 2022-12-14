class GourmetPostsController < ApplicationController

  def index
    @posts = [
      {title: "タイトル１", body: "このブログを#{'~' * 100}"},
      {title: "タイトル２", body: "このブログを#{'~' * 100}"},
      {title: "タイトル３", body: "このブログを#{'~' * 100}"},
      {title: "タイトル４", body: "このブログを#{'~' * 100}"}
    ]
  end

  def show
    @post = {title: "タイトル１", body: "このブログを#{'~' * 100}"}
  end
end
