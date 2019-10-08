class MemosController < ApplicationController

    before_action :authenticate

    include Jwt

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
    def authenticate
        token = request.headers["Authorization"]
        print token + "\n"
        begin
            decoded = validate(token)
        rescue => e
            render json: create_json(
                nil,
                e.class.to_s,
                false)
        end
        print decoded
    end

    def create_json(memos, message, ok)
        {
            memos: memos,
            message: message,
            ok: ok
        }
    end

end
