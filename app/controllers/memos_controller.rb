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

    # サンプル（削除予定）
    def find
        # findは、主キーを元に指定の値で検索する。
        # 引数は、値か配列を指定可能。
        memos = Memo.find(980190962)
        render json: create_json(
            memos,
            "find memo.",
            true)
    end

    # サンプル（削除予定）
    def find_by
        # find_byは、検索キーと値を指定して検索する。
        # 条件に一致する件数が複数ある場合は、最初の1件目を返却する。
        # 引数の検索キーと値はカンマ区切りで、複数指定可能。
        memo = Memo.find_by(title: 'MyString')
        render json: memo
=begin
        render json: create_json(
            memo,
            "find_by memo.",
            true)
=end
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
