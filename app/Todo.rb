module App
  class Todo
    def initialize(model, repo)
      @model = model
      @repo = repo
    end

    def save()
      @repo.save(model)
    end

    # アプリケーションとドメインはそれぞれ自己内に固有の他者とのみコミュニケーションする
    # アプリケーションのコミュニケーションの可能性はドメインに束縛されている
    # このモデルはアプリケーションとドメインの間を取り持つ媒介である
    # つまり、アプリケーションであると同時にドメインでなければならない
    # アプリケーションとドメインの内容を知らなければならない
  end
end
