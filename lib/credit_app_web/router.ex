defmodule CreditAppWeb.Router do
  use CreditAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :put_root_layout, {CreditAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", CreditAppWeb do
    pipe_through :browser

    get "/", UserController, :new
    post "/users", UserController, :create
    get "/survey/:id", SurveyController, :show
    post "/survey/:id", SurveyController, :update
    get "/salary/:id", SalaryController, :show
    post "/salary/:id", SalaryController, :update
  end

  if Mix.env() == :dev do
    forward "/swoosh/mailbox", Plug.Swoosh.MailboxPreview
  end
end
