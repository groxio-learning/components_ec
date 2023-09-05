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
     |> reset_turn()
     |> assign(:guess, "")}
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
    <.everything guess={@guess} game={@game} keyboard={@keyboard}/>
    <.move />
    """
  end

  def handle_event("move", _, socket) do
    {:noreply, guess(socket)}
  end

  def guess(socket) do
    new_game = Core.guess(socket.assigns.game, "guess")
    assign(socket, :game, new_game)
  end

  def move(assigns) do
    ~H"""
    <button class="button" phx-click="move">Move!</button>
    """
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

      <br />
      <br />
      <hr />
      <br />
      <br />

      <.grid>
        <.input_row guess={@guess} />

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
      <%!-- <div class="grid grid-cols-10 gap-3 text-center font-bold">
        <div class="rounded bg-green-600 pt-1 pb-1 text-white">Q</div>
        <div class="rounded bg-yellow-500 pt-1 pb-1 text-white">W</div>
        <div class="rounded bg-gray-500 pt-1 pb-1 text-white">E</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">R</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">T</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">Y</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">U</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">I</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">O</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">P</div>

        <div class="rounded bg-green-600 pt-1 pb-1 text-white">A</div>
        <div class="rounded bg-yellow-500 pt-1 pb-1 text-white">S</div>
        <div class="rounded bg-gray-500 pt-1 pb-1 text-white">D</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">F</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">G</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">H</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">J</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">K</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">L</div>
        <div></div>

        <div></div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">Z</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">X</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">C</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">V</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">B</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">N</div>
        <div class="rounded border-2 border-solid border-slate-600 pt-1 pb-1 text-black">M</div>
        <div></div>
        <div></div> --%>
      </div>
    <%!-- </div> --%>
    """
  end

  def handle_event("add-letter", %{"letter" => letter}, socket) do
    new_turn =
      socket.assigns.turn
      |> Turn.add_letter(letter)

    {:noreply, socket |> assign(:turn, new_turn) |> assign(:guess, Turn.to_guess(new_turn))}
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
    <button class={[letter_color(@color), "pt-2 pb-2 rounded"]} phx-value-letter={@letter} phx-click="add-letter">
      <%= @letter %>
    </button>
    """
  end

  def letter(assigns) do
    ~H"""
    <div class={[letter_color(@color), "pt-2 pb-2 rounded"]}>
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
end
