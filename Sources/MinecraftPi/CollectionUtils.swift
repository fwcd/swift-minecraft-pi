extension RandomAccessCollection where Index == Int {
    public subscript(safely index: Int) -> Element? {
        index >= 0 && index < count ? self[index] : nil
    }
}
