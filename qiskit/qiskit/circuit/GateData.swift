//
//  GateData.swift
//  qiskit
//
//  Created by Manoel Marques on 5/31/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import Foundation

/**
 "opaque" = True or False
 "n_args" = number of real parameters
 "n_bits" = number of qubits
 "args"   = list of parameter names
 "bits"   = list of qubit names
 "body"   = GateBody AST node
 */

final class GateData: NSCopying {

    let opaque: Bool
    let n_args: Int
    let n_bits: Int
    let args: [String]
    let bits: [String]
    let body: NodeStatment?

    init(_ opaque: Bool, _ n_args: Int, _ n_bits: Int, _ args: [String], _ bits: [String], _ body: NodeStatment?) {
        self.opaque = opaque
        self.n_args = n_args
        self.n_bits = n_bits
        self.args = args
        self.bits = bits
        self.body = body
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        return GateData(self.opaque, self.n_args, self.n_bits, self.args, self.bits, self.body)
    }
}
