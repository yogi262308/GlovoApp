public class tenPageSizeExt {
    ApexPages.StandardSetController setCon;

    public tenPageSizeExt(ApexPages.StandardSetController controller) {
        setCon = controller;
    }

    public integer getMySelectedSize() {
        return setCon.getSelected().size();
    }
    public integer getMyRecordsSize() {
        return setCon.getRecords().size();
    }
}