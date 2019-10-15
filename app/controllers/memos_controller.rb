class MemosController < ApplicationController

    before_action :auth

    include Auth

    def index
        # renderは、画面に文字列を出力する。
        render text: 'memo index'
    end

    def list
        @memos = Memo.all
        # render(jsonオプション)は、画面にJSON形式のデータを出力する。
        render json: create_json(
            @memos,
            "selected all memo.",
            true)
    end

    private
    def auth
        decoded, error = authenticate(request.headers)
        if error != nil then
            render json: create_json(
                nil,
                error.class.to_s + ":" + error.message,
                false)
        end
    end

    def create_json(memos, message, ok)
        {
            memos: memos,
            message: message,
            ok: ok
        }
    end

end
