package extract.transaction;

public enum MvtState {
    Input(0), Output(50);

    int value;

    private MvtState(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

}
