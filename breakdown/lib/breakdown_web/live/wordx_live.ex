defmodule BreakdownWeb.WordxLive do
  use BreakdownWeb, :live_view
  alias Breakdown.Game.Core
  alias Breakdown.Game
  alias Breakdown.Game.Turn

  def mount(_params, _session, socket) do
    game = Game.new()

    {:ok,
     socket
     |> assign(
       :game,
       game |> Core.guess("house") |> Core.guess("guest") |> Core.guess("guess")
     )
     |> assign(:keyboard, Core.to_keyboard(game))
     |> reset_turn()}
  end

  defp reset_turn(socket) do
    assign(socket, :turn, Turn.new())
  end

  def render(assigns) do
    ~H"""
    <pre>
      <%= inspect @turn, pretty: true %>
    </pre>
    <p>Hello World</p>
    <.everything turn={@turn} game={@game} keyboard={@keyboard} />
    """
  end

  def handle_event("make-guess", _, socket) do
    {:noreply, guess(socket)}
  end

  def handle_event("delete-letter", _, socket) do
    {:noreply, delete(socket)}
  end

  def handle_event("add-letter", %{"letter" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("add-letter", %{"letter" => letter}, socket) do
    {:noreply, assign(socket, :turn, Turn.add_letter(socket.assigns.turn, letter))}
  end

  def guess(socket) do
    case Turn.to_guess(socket.assigns.turn) do
      guess when byte_size(guess) >= 5 ->
        new_game = Game.guess(socket.assigns.game, guess)

        socket
        |> assign(:game, new_game)
        |> reset_turn()

      _ ->
        socket
        |> put_flash(:error, "Invalid guess")
    end
  end

  def delete(socket) do
    new_turn = Turn.remove_letter(socket.assigns.turn)

    socket
    |> assign(:turn, new_turn)
  end

  def everything(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <header class="flex items-center justify-between gap-6" }>
        <div>
          <h1 class="text-lg font-semibold leading-8 text-zinc-800">
            Hello,
          </h1>
          <p class="mt-2 text-sm leading-6 text-zinc-600">
            World
          </p>
        </div>
      </header>

      <hr />
      <br />
      <br />

      <.grid>
        <.input_row guess={Turn.to_guess(@turn)} />

        <.score_row :for={score <- Enum.reverse(@game.scores)} score={score} />
      </.grid>

      <br />
      <br />
      <hr />
      <br />
      <br />

      <.grid>
        <.keyboard_letter :for={{letter, color} <- @keyboard} letter={letter} color={color} />
      </.grid>
      <div class="my-4 text-center">
        <.button :if={show_enter?(@turn)} phx-click="make-guess">Enter</.button>
        <.button phx-click="delete-letter">Delete</.button>
      </div>
    </div>
    """
  end

  slot(:inner_block)

  def grid(assigns) do
    ~H"""
    <div class="grid grid-cols-5 gap-4 text-center font-bold">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:guess, :string, required: true)

  def input_row(assigns) do
    ~H"""
    <.letter :for={letter <- split_guess(@guess)} color={:white} letter={letter} />
    """
  end

  def score_row(assigns) do
    ~H"""
    <.letter :for={{letter, color} <- @score} color={color} letter={letter} />
    """
  end

  attr(:color, :atom, required: true)
  attr(:letter, :string, required: true)

  def keyboard_letter(assigns) do
    ~H"""
    <button
      class={[letter_color(@color), "pt-2 pb-2 rounded"]}
      phx-value-letter={@letter}
      phx-click="add-letter"
    >
      <%= @letter %>
    </button>
    """
  end

  def letter(assigns) do
    ~H"""
    <div class={[letter_color(@color), "pt-2 pb-2 rounded uppercase"]}>
      <%= if @letter, do: @letter, else: " " %>
    </div>
    """
  end

  defp split_guess(guess) do
    guess |> String.pad_trailing(5) |> String.graphemes()
  end

  defp letter_color(:green) do
    ["bg-green-600", "text-white"]
  end

  defp letter_color(:yellow) do
    ["bg-yellow-500", "text-white"]
  end

  defp letter_color(:gray) do
    ["bg-gray-500", "text-white"]
  end

  defp letter_color(_) do
    ["border-2", "border-gray-500"]
  end

  defp show_enter?(turn) do
    String.length(Turn.to_guess(turn)) >= 5
  end
end
