require "rails_helper"

describe StaticPagesController do
  describe "GET #home" do
    subject { get :home }

    it "renders the index template" do
      expect(subject).to render_template(:home)
      expect(subject).to render_template("home")
      expect(subject).to render_template("static_pages/home")
    end
  end
end
