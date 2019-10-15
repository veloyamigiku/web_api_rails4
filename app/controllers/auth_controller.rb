class AuthController < ApplicationController

    protect_from_forgery except: :login

    include Jwt
    include AppHash

    def login

        # リクエストパラメータにユーザ名・パスワードが存在することを確認する。
        request_user = params["user"]
        request_password = params["password"]
        if request_user == nil || request_password == nil then
            render json: create_json(
                nil,
                "request_param(user/password) is not found.",
                false)
            return
        end

        # システムにユーザが存在することを確認する。
        find_user = User.find_by(name: request_user)
        if find_user == nil then
            render json: create_json(
                nil,
                "user is not found.",
                false)
            return
        end

        # ユーザパスワードのハッシュ値と、登録済みのパスワードのハッシュ値を比較する。
        find_user_password = find_user["password"]
        hash_user_password = hash_password(request_password)
        if !(hash_user_password.eql?(find_user_password)) then
            render json: create_json(
                nil,
                "user password is invalid.",
                false)
            return
        end

        # トークン（JWT）を発行する。
        token = issue

        # トークンをJSON形式で出力する。
        render json: create_json(
            token,
            "issued token.",
            true)

    end

    private

    def create_json(token, message, ok)
        {
            token: token,
            message: message,
            ok: ok
        }
    end

end
