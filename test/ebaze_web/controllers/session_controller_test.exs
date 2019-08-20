defmodule EbazeWeb.SessionControllerTest do
    use EbazeWeb.ConnCase
    
    describe "new session" do
       
        test "renders sign-in form", %{conn: conn} do
          conn = get(conn, Routes.session_path(conn, :new))
          assert html_response(conn, 200) =~ "Sign in"
        end
    end
end 