module Configure
  
  def config(link)
    Capybara.javascript_driver = :chrome
      Capybara.configure do |config|
      config.default_driver = :selenium_chrome
      config.default_max_wait_time = 10
    end
    browser = Capybara.current_session
    driver = browser.driver.browser
    browser.visit link
    driver.page_source
  end
  
  def click_button(link, button)
    browser = Capybara.current_session
    driver = browser.driver.browser
    browser.visit link
    browser.find(:xpath, button).click
    driver.page_source
  end
end