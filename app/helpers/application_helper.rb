module ApplicationHelper
  # ViewComponentを簡単にレンダリングするヘルパーメソッド
  #
  # @param name [String, Symbol] コンポーネント名（例: "button", "card/header"）
  # @param kwargs [Hash] コンポーネントのコンストラクタに渡すキーワード引数
  # @param block [Proc] コンポーネントに渡すブロック
  #
  # example:
  #   <%= component("button", "クリック", class: "btn-primary") %>
  #   # ==> ButtonComponent.new("クリック", class: "btn-primary")をレンダリング
  #
  #   <%= component("card/header", title: "タイトル") do %>
  #     <p>内容</p>
  #   <% end %>
  #   # ==> Card::HeaderComponent.new(title: "タイトル")をレンダリング
  #
  #   <%= component("item", collection: @items) %>
  #   # ==> ItemComponent.with_collection(@items)をレンダリング
  #
  def component(name, **kwargs, &block)
    # "card/header" -> "Card::Header::Component"
    component = (name.to_s.split("/").map(&:camelize).join("::") + "::Component").constantize

    if kwargs.key?(:collection)
      render(component.with_collection(kwargs[:collection]), &block)
    else
      render(component.new(**kwargs), &block)
    end
  end
end
