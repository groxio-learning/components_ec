defmodule BreakdownWeb.WordxLive do 
  use BreakdownWeb, :live_view

  def mount(_params, _session, socket) do 
    {:ok, socket}
  end

  def render(assigns) do 
    ~H"""
    <pre>
      <%= inspect assigns, pretty: true %>
    </pre>
    <p>Hello World</p>
    <.everything />
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
    </div>
    </div>
    """
  end
end
