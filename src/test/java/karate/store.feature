Feature: Browser store automation

  Background:
    * configure driver = { type: 'chrome' }
#     * configure driverTarget = { docker: 'ptrthomas/karate-chrome', showDriverLog: true }

  Scenario: go to store website and navigate through Phones, Laptops and Monitors categories
    Given driver baseUrl
    * driver.maximize()
    When click('{a}Phones')
#    Then waitForUrl('https://www.demoblaze.com/prod.html?idp_=1')
    Then waitForText('.hrefch', 'Samsung galaxy s6')

    When click('{a}Laptops')
    Then waitForText('.hrefch', 'Sony vaio i5')

    When click('{a}Monitors')
    Then waitForText('.hrefch', 'Apple monitor 24')

  Scenario: Create an order and finalize (purchase) the order
    Given driver baseUrl
    * driver.maximize()
    And click('{a}Laptops')
    And waitForText('.hrefch', 'Sony vaio i5').click()
    When click('{a}Add to cart')
    And  retry().dialog(true)
    And click('{a}Cart')
    Then waitForText('.success', 'Sony vaio i5')
    And click('{a}Home')
    And click('{a}Sony vaio i7')
    And waitFor('{a}Add to cart').submit().click()
    And retry().dialog(true)
    And retry().click('{a}Cart')
    Then waitForText('body', 'Sony vaio i7')
#    Variables defined only to leave logical path evidence :)
    * def loc = locate('{td}Sony vaio i7').nextSibling
    * def del = loc.nextSibling.firstChild
    * def loctxt = loc.script('_.textContent')
    * print loctxt
    * def deltxt = del.script('_.textContent')
    * print deltxt
    And retry().locate('{^td}i7').nextSibling.nextSibling.firstChild.click()
    And waitForText('.success', 'Sony vaio i5')
    And waitForResultCount('tr', 2)
#    Then match driver.text('#totalp') == '790'
    And waitFor('{button}Place Order').click()
    And waitFor('{h5}Place order')
    And value('#name', 'John Doe')
    And value('#country', 'Spain')
    And value('#city', 'Madrid')
    And value('#card', '344434544586759')
    And value('#month', '04')
    And value('#year', '2026')
#    Then waitFor('{button}Purchase').click()
    Then retry().submit().click('{button}Purchase')
    And waitForText('body', 'Thank you for your purchase!')
    * def orderDetails = locate('{^p}Id').script('_.textContent')
    * print orderDetails
    * def orderId = text('/html/body/div[10]/p/text()[1]')
    * def orderAmt = text('/html/body/div[10]/p/text()[2]')
    * print orderId
    * print orderAmt
    Then match orderAmt == 'Amount: 790 USD'
    * retry().screenshot('body > div.sweet-alert.showSweetAlert.visible')
    And retry().submit().click('{button}OK')