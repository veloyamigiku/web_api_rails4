class MemosController < ApplicationController

    def index
        # renderは、画面に文字列を出力する。
        render text: 'memo index'
    end

    def list
        @memos = Memo.all
        # render(jsonオプション)は、画面にJSON形式のデータを出力する。
        render json: @memos
    end

end
