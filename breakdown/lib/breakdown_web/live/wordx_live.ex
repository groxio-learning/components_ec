defmodule BreakdownWeb.WordxLive do
  use BreakdownWeb, :live_view
  alias Breakdown.Game.Core

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :game, Core.new())}

  end

  def render(assigns) do
    ~H"""
    <pre>
      <%= inspect @game, pretty: true %>
    </pre>
    <p>Hello World</p>
    <.everything />
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
    <header class="flex items-center justify-between gap-6"}>
    <div>
        <h1 class="text-lg font-semibold leading-8 text-zinc-800">
        Hello,
        </h1>
        <p class="mt-2 text-sm leading-6 text-zinc-600">
        World
        </p>
    </div>
    </header>

    <br/>
    <br/>
    <hr/>
    <br/>
    <br/>

    <div class="grid grid-cols-5 gap-4 text-center font-bold">
        <div class="rounded border-2 border-gray-500 pt-2 pb-2 text-white">-</div>
        <div class="rounded border-2 border-gray-500 pt-2 pb-2"> </div>
        <div class="rounded border-2 border-gray-500 pt-2 pb-2"> </div>
        <div class="rounded border-2 border-gray-500 pt-2 pb-2"> </div>
        <div class="rounded border-2 border-gray-500 pt-2 pb-2"> </div>

        <div class="rounded bg-green-600 pt-2 pb-2 text-white">G</div>
        <div class="rounded bg-yellow-500 pt-2 pb-2 text-white">U</div>
        <div class="rounded bg-gray-500 pt-2 pb-2 text-white">E</div>
        <div class="rounded bg-green-600 pt-2 pb-2 text-white">S</div>
        <div class="rounded bg-yellow-500 pt-2 pb-2 text-white">S</div>

        <div class="rounded bg-green-600 pt-2 pb-2 text-white">G</div>
        <div class="rounded bg-yellow-500 pt-2 pb-2 text-white">U</div>
        <div class="rounded bg-gray-500 pt-2 pb-2 text-white">E</div>
        <div class="rounded bg-green-600 pt-2 pb-2 text-white">S</div>
        <div class="rounded bg-yellow-500 pt-2 pb-2 text-white">S</div>

        <div class="rounded bg-green-600 pt-2 pb-2 text-white">G</div>
        <div class="rounded bg-yellow-500 pt-2 pb-2 text-white">U</div>
        <div class="rounded bg-gray-500 pt-2 pb-2 text-white">E</div>
        <div class="rounded bg-green-600 pt-2 pb-2 text-white">S</div>
        <div class="rounded bg-yellow-500 pt-2 pb-2 text-white">S</div>

        <div class="rounded bg-green-600 pt-2 pb-2 text-white">G</div>
        <div class="rounded bg-yellow-500 pt-2 pb-2 text-white">U</div>
        <div class="rounded bg-gray-500 pt-2 pb-2 text-white">E</div>
        <div class="rounded bg-green-600 pt-2 pb-2 text-white">S</div>
        <div class="rounded bg-yellow-500 pt-2 pb-2 text-white">S</div>

        <div class="rounded bg-green-600 pt-2 pb-2 text-white">G</div>
        <div class="rounded bg-yellow-500 pt-2 pb-2 text-white">U</div>
        <div class="rounded bg-gray-500 pt-2 pb-2 text-white">E</div>
        <div class="rounded bg-green-600 pt-2 pb-2 text-white">S</div>
        <div class="rounded bg-yellow-500 pt-2 pb-2 text-white">S</div>
    </div>

    <br/>
    <br/>
    <hr/>
    <br/>
    <br/>

    <div class="grid grid-cols-10 gap-3 text-center font-bold">
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
        <div></div>
    </div>
    </div>
    """
  end
end
