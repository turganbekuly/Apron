extension Array where Element: Equatable {

    // MARK: - Unique

    public func uniqueElements() -> [Element] {
        var output = [Element]()

        for element in self where !output.contains(element) {
            output.append(element)
        }

        return output
    }

}
