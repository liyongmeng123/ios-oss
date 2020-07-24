@testable import KsApi
import XCTest

final class ManagePledgeViewBackingEnvelopeTests: XCTestCase {
  func testJSONParsing_WithCompleteData() {
    let dictionary: [String: Any] = [
      "backing": [
        "project": [
          "pid": 747_474_738,
          "name": "The Keyboardio Atreus",
          "state": "LIVE"
        ],
        "backerCompleted": false,
        "addOns": [
          "nodes": [
            [
              "amount": [
                "amount": "179.0",
                "currency": "USD",
                "symbol": "$"
              ],
              "backersCount": 2,
              "description": "Best Add-on",
              "displayName": "Crowdfunding Special ($179)",
              "estimatedDeliveryOn": "2020-07-01",
              "id": "UmV3YXJkLTc2MDEyNDk=",
              "isMaxPledge": false,
              "items": [
                "nodes": []
              ],
              "limit": nil,
              "name": "Crowdfunding Special",
              "remainingQuantity": nil,
              "startsAt": nil
            ]
          ]
        ],
        "id": "UHJvamVjdC00NDc0NzMM=",
        "status": "pledged",
        "errorReason": "This just isn't your day.",
        "pledgedOn": 1_587_502_131,
        "bonusAmount": [
          "amount": "5.0",
          "currency": "USD",
          "symbol": "$"
        ],
        "amount": [
          "amount": "146.0",
          "currency": "USD",
          "symbol": "$"
        ],
        "bankAccount": [
          "bankName": "Chase",
          "id": "60922339",
          "lastFour": "1234"
        ],
        "cancelable": true,
        "creditCard": [
          "id": "60981339",
          "lastFour": "1234",
          "expirationDate": "2023-04-01",
          "paymentType": "CREDIT_CARD",
          "type": "VISA"
        ],
        "location": [
          "country": "CA",
          "countryName": "Canada",
          "displayableName": "Canada",
          "id": "TG9jYXRpb24tMjM0MjQ3NzU=",
          "name": "Canada"
        ],
        "sequence": 5,
        "shippingAmount": [
          "amount": "17.0",
          "currency": "USD",
          "symbol": "$"
        ],
        "reward": [
          "id": "reward-id",
          "name": "Everyday Carry",
          "backersCount": 593,
          "isMaxPledge": false,
          "description": "For the typist who takes their keyboard everywhere.",
          "displayName": "Display name",
          "endsAt": 1_587_602_131,
          "startsAt": 1_587_562_131,
          "estimatedDeliveryOn": "2020-08-01",
          "items": [
            "nodes": [
              [
                "id": "UmV3YXJkSXRlbS03OTczNTM=",
                "name": "Keyboardio Atreus (Choose switches after campaign)"
              ],
              [
                "id": "UmV3YXJkSXRlbS04NzMzMDY=",
                "name": "Travel case"
              ]
            ]
          ],
          "limit": 5,
          "limitPerBacker": 2,
          "remainingQuantity": 10,
          "shippingPreference": "none",
          "amount": [
            "amount": "129.0",
            "currency": "USD",
            "symbol": "$"
          ]
        ],
        "backer": [
          "uid": "565656",
          "name": "Backer McGee"
        ]
      ]
    ]

    guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
      XCTFail("Should have data")
      return
    }

    do {
      let value = try JSONDecoder().decode(ManagePledgeViewBackingEnvelope.self, from: data)

      XCTAssertEqual(value.project.pid, 747_474_738)
      XCTAssertEqual(value.project.name, "The Keyboardio Atreus")
      XCTAssertEqual(value.project.state, .live)

      XCTAssertEqual(value.backing.id, "UHJvamVjdC00NDc0NzMM=")
      XCTAssertEqual(value.backing.status, .pledged)
      XCTAssertEqual(value.backing.sequence, 5)
      XCTAssertEqual(value.backing.errorReason, "This just isn't your day.")
      XCTAssertEqual(value.backing.pledgedOn, 1_587_502_131)
      XCTAssertEqual(value.backing.amount, Money(amount: 146.0, currency: .usd, symbol: "$"))
      XCTAssertEqual(value.backing.backerCompleted, false)

      XCTAssertEqual(value.backing.bonusAmount, Money(amount: 5.0, currency: .usd, symbol: "$"))

      XCTAssertEqual(value.backing.bankAccount?.bankName, "Chase")
      XCTAssertEqual(value.backing.bankAccount?.id, "60922339")
      XCTAssertEqual(value.backing.bankAccount?.lastFour, "1234")

      XCTAssertEqual(value.backing.cancelable, true)

      XCTAssertEqual(value.backing.creditCard?.id, "60981339")
      XCTAssertEqual(value.backing.creditCard?.lastFour, "1234")
      XCTAssertEqual(value.backing.creditCard?.expirationDate, "2023-04-01")
      XCTAssertEqual(value.backing.creditCard?.paymentType, .creditCard)
      XCTAssertEqual(value.backing.creditCard?.type, .visa)

      XCTAssertEqual(value.backing.location?.name, "Canada")
      XCTAssertEqual(value.backing.location?.countryName, "Canada")
      XCTAssertEqual(value.backing.location?.country, "CA")
      XCTAssertEqual(value.backing.location?.displayableName, "Canada")
      XCTAssertEqual(value.backing.location?.id, "TG9jYXRpb24tMjM0MjQ3NzU=")

      XCTAssertEqual(value.backing.shippingAmount, Money(amount: 17.0, currency: .usd, symbol: "$"))

      XCTAssertEqual(value.backing.addOns?.nodes[0].id, "UmV3YXJkLTc2MDEyNDk=")
      XCTAssertEqual(value.backing.addOns?.nodes[0].amount, Money(amount: 179.0, currency: .usd, symbol: "$"))
      XCTAssertEqual(value.backing.addOns?.nodes[0].backersCount, 2)
      XCTAssertEqual(value.backing.addOns?.nodes[0].description, "Best Add-on")
      XCTAssertEqual(value.backing.addOns?.nodes[0].displayName, "Crowdfunding Special ($179)")
      XCTAssertEqual(value.backing.addOns?.nodes[0].name, "Crowdfunding Special")
      XCTAssertEqual(value.backing.addOns?.nodes[0].isMaxPledge, false)
      XCTAssertEqual(value.backing.addOns?.nodes[0].items?.count, 0)
      XCTAssertEqual(value.backing.addOns?.nodes[0].limit, nil)
      XCTAssertEqual(value.backing.addOns?.nodes[0].remainingQuantity, nil)
      XCTAssertEqual(value.backing.addOns?.nodes[0].startsAt, nil)

      XCTAssertEqual(value.backing.reward?.id, "reward-id")
      XCTAssertEqual(value.backing.reward?.name, "Everyday Carry")
      XCTAssertEqual(value.backing.reward?.backersCount, 593)
      XCTAssertEqual(
        value.backing.reward?.description,
        "For the typist who takes their keyboard everywhere."
      )

      XCTAssertEqual(value.backing.reward?.endsAt, 1_587_602_131)
      XCTAssertEqual(value.backing.reward?.startsAt, 1_587_562_131)
      XCTAssertEqual(value.backing.reward?.estimatedDeliveryOn, "2020-08-01")
      XCTAssertEqual(value.backing.reward?.items?[0].id, "UmV3YXJkSXRlbS03OTczNTM=")
      XCTAssertEqual(
        value.backing.reward?.items?[0].name,
        "Keyboardio Atreus (Choose switches after campaign)"
      )
      XCTAssertEqual(value.backing.reward?.items?[1].id, "UmV3YXJkSXRlbS04NzMzMDY=")
      XCTAssertEqual(value.backing.reward?.items?[1].name, "Travel case")

      XCTAssertEqual(value.backing.reward?.limit, 5)
      XCTAssertEqual(value.backing.reward?.limitPerBacker, 2)
      XCTAssertEqual(value.backing.reward?.remainingQuantity, 10)

      XCTAssertEqual(value.backing.reward?.amount, Money(amount: 129.0, currency: .usd, symbol: "$"))

      XCTAssertEqual(value.backing.reward?.shippingPreference, .noShipping)

      XCTAssertEqual(value.backing.backer.uid, 565_656)
      XCTAssertEqual(value.backing.backer.name, "Backer McGee")
    } catch {
      XCTFail((error as NSError).description)
    }
  }

  func testJSONParsing_WithPartialData() {
    let dictionary: [String: Any] = [
      "backing": [
        "project": [
          "pid": 747_474_738,
          "name": "The Keyboardio Atreus",
          "state": "LIVE"
        ],
        "backerCompleted": false,
        "id": "UHJvamVjdC00NDc0NzMM=",
        "sequence": 123,
        "status": "pledged",
        "errorReason": nil,
        "pledgedOn": 1_587_502_131,
        "amount": [
          "amount": "146.0",
          "currency": "USD",
          "symbol": "$"
        ],
        "bankAccount": nil,
        "cancelable": true,
        "creditCard": nil,
        "location": nil,
        "shippingAmount": nil,
        "reward": [
          "id": "reward-id",
          "name": "Everyday Carry",
          "backersCount": 593,
          "description": "For the typist who takes their keyboard everywhere.",
          "isMaxPledge": false,
          "displayName": "Display name",
          "estimatedDeliveryOn": nil,
          "items": nil,
          "amount": [
            "amount": "129.0",
            "currency": "USD",
            "symbol": "$"
          ]
        ],
        "backer": [
          "uid": "565656",
          "name": "Backer McGee"
        ]
      ]
    ]

    guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
      XCTFail("Should have data")
      return
    }

    do {
      let value = try JSONDecoder().decode(ManagePledgeViewBackingEnvelope.self, from: data)

      XCTAssertEqual(value.project.pid, 747_474_738)
      XCTAssertEqual(value.project.name, "The Keyboardio Atreus")
      XCTAssertEqual(value.project.state, .live)

      XCTAssertEqual(value.backing.id, "UHJvamVjdC00NDc0NzMM=")
      XCTAssertEqual(value.backing.sequence, 123)
      XCTAssertEqual(value.backing.status, .pledged)
      XCTAssertNil(value.backing.errorReason)
      XCTAssertEqual(value.backing.pledgedOn, 1_587_502_131)
      XCTAssertEqual(value.backing.amount, Money(amount: 146.0, currency: .usd, symbol: "$"))

      XCTAssertNil(value.backing.bankAccount)

      XCTAssertEqual(value.backing.cancelable, true)

      XCTAssertNil(value.backing.creditCard)

      XCTAssertNil(value.backing.location)
      XCTAssertNil(value.backing.shippingAmount)

      XCTAssertEqual(value.backing.reward?.id, "reward-id")
      XCTAssertEqual(value.backing.reward?.name, "Everyday Carry")
      XCTAssertEqual(value.backing.reward?.backersCount, 593)
      XCTAssertEqual(
        value.backing.reward?.description,
        "For the typist who takes their keyboard everywhere."
      )
      XCTAssertNil(value.backing.reward?.estimatedDeliveryOn)
      XCTAssertNil(value.backing.reward?.items)

      XCTAssertEqual(value.backing.reward?.amount, Money(amount: 129.0, currency: .usd, symbol: "$"))

      XCTAssertEqual(value.backing.backer.uid, 565_656)
      XCTAssertEqual(value.backing.backer.name, "Backer McGee")
    } catch {
      XCTFail((error as NSError).description)
    }
  }

  func testJSONParsing_WithPartialData_NoReward() {
    let dictionary: [String: Any] = [
      "backing": [
        "project": [
          "pid": 747_474_738,
          "name": "The Keyboardio Atreus",
          "state": "LIVE"
        ],
        "backerCompleted": false,
        "id": "UHJvamVjdC00NDc0NzMM=",
        "sequence": 123,
        "status": "pledged",
        "errorReason": nil,
        "pledgedOn": 1_587_502_131,
        "amount": [
          "amount": "146.0",
          "currency": "USD",
          "symbol": "$"
        ],
        "bankAccount": nil,
        "cancelable": true,
        "creditCard": nil,
        "location": nil,
        "shippingAmount": nil,
        "reward": nil,
        "backer": [
          "uid": "565656",
          "name": "Backer McGee"
        ]
      ]
    ]

    guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
      XCTFail("Should have data")
      return
    }

    do {
      let value = try JSONDecoder().decode(ManagePledgeViewBackingEnvelope.self, from: data)

      XCTAssertEqual(value.project.pid, 747_474_738)
      XCTAssertEqual(value.project.name, "The Keyboardio Atreus")
      XCTAssertEqual(value.project.state, .live)

      XCTAssertEqual(value.backing.id, "UHJvamVjdC00NDc0NzMM=")
      XCTAssertEqual(value.backing.sequence, 123)
      XCTAssertEqual(value.backing.status, .pledged)
      XCTAssertNil(value.backing.errorReason)
      XCTAssertEqual(value.backing.pledgedOn, 1_587_502_131)
      XCTAssertEqual(value.backing.amount, Money(amount: 146.0, currency: .usd, symbol: "$"))

      XCTAssertNil(value.backing.bankAccount)

      XCTAssertEqual(value.backing.cancelable, true)

      XCTAssertNil(value.backing.creditCard)

      XCTAssertNil(value.backing.location)
      XCTAssertNil(value.backing.shippingAmount)

      XCTAssertNil(value.backing.reward)

      XCTAssertEqual(value.backing.backer.uid, 565_656)
      XCTAssertEqual(value.backing.backer.name, "Backer McGee")
    } catch {
      XCTFail((error as NSError).description)
    }
  }

  func testJSONParsing_WithPartialData_CreatorContext() {
    let dictionary: [String: Any] = [
      "backing": [
        "amount": [
          "amount": "1.0",
          "currency": "USD",
          "symbol": "$"
        ],
        "backerCompleted": false,
        "backer": [
          "name": "Backer McGee",
          "uid": "110079315"
        ],
        "cancelable": false,
        "creditCard": nil,
        "errorReason": nil,
        "id": "QmFja2luZy02NDUxNTcyMg==",
        "pledgedOn": 1_502_727_496,
        "project": [
          "name": "The Keyboardio Atreus",
          "pid": 747_474_738,
          "state": "SUCCESSFUL"
        ],
        "reward": [
          "id": "reward-id",
          "isMaxPledge": false,
          "amount": [
            "amount": "1.0",
            "currency": "USD",
            "symbol": "$"
          ],
          "backersCount": 1,
          "description": "Best description",
          "displayName": "Display name",
          "estimatedDeliveryOn": "2017-08-01",
          "items": [
            "nodes": [
              [
                "id": "UmV3YXJkSXRlbS03OTczNTM=",
                "name": "Keyboardio Atreus (Choose switches after campaign)"
              ],
              [
                "id": "UmV3YXJkSXRlbS04NzMzMDY=",
                "name": "Travel case"
              ]
            ]
          ],
          "name": "Reward title"
        ],
        "sequence": 1,
        "shippingAmount": [
          "amount": "17.0",
          "currency": "USD",
          "symbol": "$"
        ],
        "status": "collected"
      ]
    ]

    guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
      XCTFail("Should have data")
      return
    }

    do {
      let value = try JSONDecoder().decode(ManagePledgeViewBackingEnvelope.self, from: data)

      XCTAssertEqual(value.project.pid, 747_474_738)
      XCTAssertEqual(value.project.name, "The Keyboardio Atreus")
      XCTAssertEqual(value.project.state, .successful)

      XCTAssertEqual(value.backing.id, "QmFja2luZy02NDUxNTcyMg==")
      XCTAssertEqual(value.backing.sequence, 1)
      XCTAssertEqual(value.backing.status, .collected)
      XCTAssertNil(value.backing.errorReason)
      XCTAssertEqual(value.backing.pledgedOn, 1_502_727_496)
      XCTAssertEqual(value.backing.amount, Money(amount: 1.0, currency: .usd, symbol: "$"))

      XCTAssertNil(value.backing.bankAccount)

      XCTAssertEqual(value.backing.cancelable, false)

      XCTAssertNil(value.backing.creditCard)

      XCTAssertNil(value.backing.location)
      XCTAssertEqual(value.backing.shippingAmount, Money(amount: 17.0, currency: .usd, symbol: "$"))

      XCTAssertEqual(value.backing.reward?.id, "reward-id")
      XCTAssertEqual(value.backing.reward?.name, "Reward title")
      XCTAssertEqual(value.backing.reward?.backersCount, 1)
      XCTAssertEqual(value.backing.reward?.description, "Best description")
      XCTAssertEqual(value.backing.reward?.estimatedDeliveryOn, "2017-08-01")
      XCTAssertEqual(value.backing.reward?.items?[0].id, "UmV3YXJkSXRlbS03OTczNTM=")
      XCTAssertEqual(
        value.backing.reward?.items?[0].name,
        "Keyboardio Atreus (Choose switches after campaign)"
      )
      XCTAssertEqual(value.backing.reward?.items?[1].id, "UmV3YXJkSXRlbS04NzMzMDY=")
      XCTAssertEqual(value.backing.reward?.items?[1].name, "Travel case")

      XCTAssertEqual(value.backing.backer.uid, 110_079_315)
      XCTAssertEqual(value.backing.backer.name, "Backer McGee")
    } catch {
      XCTFail((error as NSError).description)
    }
  }
}
