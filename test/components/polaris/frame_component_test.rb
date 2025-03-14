require "test_helper"

class FrameComponentTest < Minitest::Test
  include Polaris::ComponentTestHelpers

  def test_default_frame
    render_inline(Polaris::FrameComponent.new(logo: {
      url: "/root_url",
      src: "http://example.com/logo.jpg"
    })) do |frame|
      frame.top_bar do |top_bar|
        top_bar.user_menu(name: "Kirill", detail: "Platmart") do |user_menu|
          user_menu.avatar(initials: "K")
          "Popover Content"
        end
      end
      frame.navigation do |navigation|
        navigation.item(url: "#", label: "Home", icon: "HomeMajor")
      end
      frame.save_bar(message: "SaveBar Message") do |save_bar|
        save_bar.save_action { "Save" }
        save_bar.discard_action { "Discard" }
      end

      "Frame Content"
    end

    assert_selector ".Polaris-Frame" do
      assert_selector ".Polaris-Frame__Navigation" do
        assert_selector ".Polaris-Navigation" do
          assert_text "Home"
        end
        assert_selector ".Polaris-Frame__NavigationDismiss"
      end
      assert_selector ".Polaris-Frame-ContextualSaveBar" do
        assert_text "SaveBar Message"
      end

      assert_selector ".Polaris-Frame__Main > .Polaris-Frame__Content" do
        assert_text "Frame Content"
      end
    end
  end
end
