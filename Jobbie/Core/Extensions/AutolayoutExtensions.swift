//
//  AutolayoutExtensions.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//
import UIKit

extension UIView {

    @discardableResult
    func add(to parent: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)

        return self
    }

    @discardableResult
    func pinToEdges(of view: UIView? = nil,
                           withInsets insets: UIEdgeInsets = .zero) -> Self {
        let view = view ?? parent
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: insets.right)
        ])

        return self
    }

    @discardableResult
    public func top<YAxis>(
        to anchor: KeyPath<UIView, YAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> Self where YAxis: NSLayoutYAxisAnchor {
        addTopConstraint(to: anchor, of: view, constant: constant, priority: priority)
        return self
    }

    @discardableResult
    public func addTopConstraint<YAxis>(
        to anchor: KeyPath<UIView, YAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint where YAxis: NSLayoutYAxisAnchor {
        return topAnchor
             .constraint(equalTo: (view ?? parent)[keyPath: anchor])
            .offset(constant)
            .priority(priority)
            .activate()
    }

    @discardableResult
    public func addBottomConstraint<YAxis>(
        to anchor: KeyPath<UIView, YAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint where YAxis: NSLayoutYAxisAnchor {
        return bottomAnchor
            .constraint(equalTo: (view ?? parent)[keyPath: anchor])
            .offset(-constant)
            .priority(priority)
            .activate()
    }

    @discardableResult
    public func bottom<YAxis>(
        to anchor: KeyPath<UIView, YAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> Self where YAxis: NSLayoutYAxisAnchor {
        addBottomConstraint(to: anchor, of: view, constant: constant, priority: priority)
        return self
    }

    @discardableResult
    public func addLeadingConstraint<XAxis>(
        to anchor: KeyPath<UIView, XAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint where XAxis: NSLayoutXAxisAnchor {
        return leadingAnchor
            .constraint(equalTo: (view ?? parent)[keyPath: anchor])
            .offset(constant)
            .priority(priority)
            .activate()
    }

    @discardableResult
    public func leading<XAxis>(
        to anchor: KeyPath<UIView, XAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> Self where XAxis: NSLayoutXAxisAnchor {
        addLeadingConstraint(to: anchor, of: view, constant: constant, priority: priority)
        return self
    }

    @discardableResult
    public func addTrailingConstraint<XAxis>(
        to anchor: KeyPath<UIView, XAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint where XAxis: NSLayoutXAxisAnchor {
        return trailingAnchor
            .constraint(equalTo: (view ?? parent)[keyPath: anchor])
            .offset(-constant)
            .priority(priority)
            .activate()
    }

    @discardableResult
    public func trailing<XAxis>(
        to anchor: KeyPath<UIView, XAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> Self where XAxis: NSLayoutXAxisAnchor {
        addTrailingConstraint(to: anchor, of: view, constant: constant, priority: priority)
        return self
    }


    @discardableResult
    public func center(in view: UIView? = nil, withMargin margin: CGFloat = 0) -> Self {
        return centerX(to: \.centerXAnchor, of: view, constant: margin)
            .centerY(to: \.centerYAnchor, of: view, constant: margin)
    }

    @discardableResult
    public func addCenterXConstraint<XAxis>(
        to anchor: KeyPath<UIView, XAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint where XAxis: NSLayoutXAxisAnchor {
        return centerXAnchor
            .constraint(equalTo: (view ?? parent)[keyPath: anchor])
            .offset(constant)
            .priority(priority)
            .activate()
    }

    @discardableResult
    public func centerX<XAxis>(
        to anchor: KeyPath<UIView, XAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> Self where XAxis: NSLayoutXAxisAnchor {
        addCenterXConstraint(to: anchor, of: view, constant: constant, priority: priority)
        return self
    }

    @discardableResult
    public func addCenterYConstraint<YAxis>(
        to anchor: KeyPath<UIView, YAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint where YAxis: NSLayoutYAxisAnchor {
        return centerYAnchor
            .constraint(equalTo: (view ?? parent)[keyPath: anchor])
            .offset(constant)
            .priority(priority)
            .activate()
    }

    @discardableResult
    public func centerY<YAxis>(
        to anchor: KeyPath<UIView, YAxis>,
        of view: UIView? = nil,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
        ) -> Self where YAxis: NSLayoutYAxisAnchor {
        addCenterYConstraint(to: anchor, of: view, constant: constant, priority: priority)
        return self
    }

    var parent: UIView {
        guard let parent = superview else { fatalError("The view has no superview") }
        return parent
    }
}

extension NSLayoutConstraint {
    func offset(_ offset: CGFloat) -> Self {
        constant = offset
        return self
    }

    func activate() -> Self {
        isActive = true
        return self
    }

    func priority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
