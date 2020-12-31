class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    category = Category.create(category_params)

    respond_to do |format|
      # この辺りの仕様をみると何がしたいかわかる https://turbo.hotwire.dev/handbook/streams
      format.turbo_stream do
        render(
          turbo_stream:
            turbo_stream.append(
              :categories,
              partial: "categories/category",
              locals: { category: category }
            )
        )
      end

      format.html { redirect_to(action: :index) }
      # ポスト前と同じアクション(今回はindex)に返すことで、streamが動作しなくても問題ないようにする
      # (これがstreamが動かなくてもサービスが停止しない理由)
      # 見た目同じような挙動になるので、networkタブを確認すること
      # 302になってたらhotwireがうまく動いてない
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
  
    respond_to do |format|
      format.turbo_stream do
        render(turbo_stream: turbo_stream.remove(category))
      end

      format.html { redirect_to(action: :index) }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end