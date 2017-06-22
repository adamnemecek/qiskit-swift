//
//  ExpressionList.swift
//  qiskit
//
//  Created by Joe Ligman on 6/4/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import Foundation

@objc public final class NodeExpressionList: Node {

    public var expressionList: [Node]? = nil
    
    public init(expression: Node?) {
        super.init()
        if let exp = expression {
            if expressionList == nil {
                self.expressionList = [exp]
            } else {
                expressionList!.append(self)
            }
        }
    }

    public func addExpression(exp: Node) {
        expressionList?.append(exp)
    }
    
    public override var type: NodeType {
        return .N_EXPRESSIONLIST
    }
    
    public override func qasm() -> String {
        var qasms: [String] = []
        if let list = expressionList?.reversed() {
            qasms = list.flatMap({ (node: Node) -> String in
                return node.qasm()
            })
        }
        return qasms.joined(separator: ",")
    }
}
