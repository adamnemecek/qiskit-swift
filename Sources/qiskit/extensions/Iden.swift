// Copyright 2017 IBM RESEARCH. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// =============================================================================


import Foundation

/**
 Identity gate.
 */
public final class IdGate: Gate {

    fileprivate init(_ qubit: QuantumRegisterTuple, _ circuit: QuantumCircuit? = nil) {
        super.init("id", [], [qubit], circuit)
    }

    public override var description: String {
        return self._qasmif("\(name) \(self.args[0].identifier)")
    }

    /**
     Invert this gate.
     */
    public override func inverse() -> Gate {
        return self
    }

    /**
     Reapply this gate to corresponding qubits in circ.
     */
    public override func reapply(_ circ: QuantumCircuit) throws {
        try self._modifiers(circ.iden(self.args[0] as! QuantumRegisterTuple))
    }
}

extension QuantumCircuit {

    /**
     Apply Identity to q.
     */
    public func iden(_ q: QuantumRegister) throws -> InstructionSet {
        let gs = InstructionSet()
        for j in 0..<q.size {
            gs.add(try self.iden(QuantumRegisterTuple(q,j)))
        }
        return gs
    }

    /**
     Apply Identity to q.
     */
    @discardableResult
    public func iden(_ q: QuantumRegisterTuple) throws -> IdGate {
        try  self._check_qubit(q)
        return self._attach(IdGate(q, self)) as! IdGate
    }
}

extension CompositeGate {

    /**
     Apply Identity to q.
     */
    public func iden(_ q: QuantumRegister) throws -> InstructionSet {
        let gs = InstructionSet()
        for j in 0..<q.size {
            gs.add(try self.iden(QuantumRegisterTuple(q,j)))
        }
        return gs
    }

    /**
     Apply Identity to q.
     */
    @discardableResult
    public func iden(_ q: QuantumRegisterTuple) throws -> IdGate {
        try  self._check_qubit(q)
        return self._attach(IdGate(q, self.circuit)) as! IdGate
    }
}