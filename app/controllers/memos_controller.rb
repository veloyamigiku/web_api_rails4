class MemosController < ApplicationController

    protect_from_forgery except: :create

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

    def delete

        memo_id = params["id"].to_i
        memo = Memo.find_by(id: memo_id)

        respond_to do |format|
            if memo == nil
                format.json {
                    render json: create_json(
                        memo,
                        "delete ng",
                        false)
                }
            else
                # destroyは、モデルをテーブルから削除する。
                # 戻り値は、
                # 削除が成功した場合はモデルデータ。
                # 削除が失敗した場合はfalse。
                destory_memo = memo.destroy
                if destory_memo
                    format.json {
                        render json: create_json(
                            destory_memo,
                            "delete ok",
                            true)
                    }
                else
                    format.json {
                        render json: create_json(
                            memo,
                            "delete ng",
                            false)
                    }
                end
            end
        end

    end

    def update
        memo_id = params["id"].to_i
        memo = Memo.find_by(id: memo_id)

        respond_to do |format|
            # updateは、指定の更新データ（ハッシュ）でモデルのテーブルを更新する。
            if memo != nil && memo.update(memo_params)
                # 更新対象のモデルが存在して、かつ更新に成功した場合の処理を定義する。
                format.json {
                    render json: create_json(
                        memo,
                        "memo update ok",
                        true)
                }
            else
                # 上記以外（更新失敗）の場合の処理を定義する。
                format.json {
                    render json: create_json(
                        memo,
                        "memo update ng",
                        false)
                }
            end

        end

    end

    def create
        memo = Memo.new(memo_params)

        # respond_to/format.xxxで、出力フォーマット毎の処理を定義する。
        respond_to do |format|
            # saveは、モデルをテーブルに登録する。
            # 登録結果を真偽値で返却する。
            if memo.save
                format.html {
                    render text: "create ok"
                }
                format.json {
                    render json: create_json(
                        memo,
                        "create ok",
                        true)
                }
                format.jpg {
                    render text: "mime:jpg ok"
                }
            else
                format.html {
                    render text: "create ng"
                }
                format.json {
                    render json: create_json(
                        memo,
                        memo.errors.to_s,
                        false
                    )
                }
                format.jpg {
                    render text: "mime:jpg ng"
                }
            end
        end

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

    def memo_params
        params.require(:memo_post).permit(
            :title,
            :content)
    end

end
