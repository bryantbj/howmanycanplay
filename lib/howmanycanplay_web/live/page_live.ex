defmodule HowmanycanplayWeb.PageLive do
  use HowmanycanplayWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>Hello, world!</div>
    """
  end
end
