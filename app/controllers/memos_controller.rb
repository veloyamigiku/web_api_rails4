class MemosController < ApplicationController

    def index
        # renderは、画面に文字列を出力する。
        render text: 'memo index'
    end

end
