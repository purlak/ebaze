defmodule EbazeWeb.SessionControllerTest do
    use EbazeWeb.ConnCase
  
    alias Ebaze.Accounts
    
    describe "new session" do
       
        test "renders login form", %{conn: conn} do
          conn = get(conn, Routes.session_path(conn, :new))
          assert html_response(conn, 200) =~ "Sign in"
        end
    end
end 