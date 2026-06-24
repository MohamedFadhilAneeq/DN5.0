public class TestFactory {
    public static void main(String[] args) {
        DocumentFactory wordFactory = new WordFactory();
        Document myWordDoc = wordFactory.createDocument();
        myWordDoc.type();
        DocumentFactory pdfFactory = new PdfFactory();
        Document myPdfDoc = pdfFactory.createDocument();
        myPdfDoc.type();
        DocumentFactory excelFactory = new ExcelFactory();
        Document myExcelDoc = excelFactory.createDocument();
        myExcelDoc.type();
    }
}
