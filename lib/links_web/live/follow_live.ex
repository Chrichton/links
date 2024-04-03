defmodule LinksWeb.FollowLive do
  use LinksWeb, :live_view

  def mount(_params, _session, socket) do
    Process.sleep(300)

    socket =
      socket
      |> follow({:mount, connected?(socket)})

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    Hello
    <pre>
    <%= @follows |> Enum.reverse() |> inspect() %>
    <hr>
    </pre>

    <.link href={~p"/follow"}>http</.link>
    <.link patch={~p"/follow"}>patch</.link>
    <.link navigate={~p"/follow"}>navigate</.link>
    """
  end

  def follow(socket, data) do
    follows = Map.get(socket.assigns, :follows) || []
    assign(socket, follows: [data | follows])
  end

  def handle_params(_unsigned_params, _uri, socket) do
    socket =
      socket
      |> follow({:handle_params, connected?(socket)})

    {:noreply, socket}
  end
end
