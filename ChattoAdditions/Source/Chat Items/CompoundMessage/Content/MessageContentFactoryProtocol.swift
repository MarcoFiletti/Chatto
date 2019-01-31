//
// The MIT License (MIT)
//
// Copyright (c) 2015-present Badoo Trading Limited.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

public protocol MessageContentFactoryProtocol {
    associatedtype Model
    typealias ChildPresenter = Any
    func canCreateMessage(forModel model: Model) -> Bool
    func createMessage(forModel model: Model) -> (UIView, ChildPresenter)
}

public struct AnyMessageContentFactory<T>: MessageContentFactoryProtocol {

    private let _canCreateMessage: (T) -> Bool
    private let _createMessage: (T) -> (UIView, ChildPresenter)

    public init<U: MessageContentFactoryProtocol>(_ base: U) where U.Model == T {
        self._canCreateMessage = base.canCreateMessage
        self._createMessage = base.createMessage
    }

    public func canCreateMessage(forModel model: T) -> Bool {
        return self._canCreateMessage(model)
    }

    public func createMessage(forModel model: T) -> (UIView, ChildPresenter) {
        return self._createMessage(model)
    }
}
