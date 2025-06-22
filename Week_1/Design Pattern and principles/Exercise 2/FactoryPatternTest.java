
public class DocumentTest {
    public static void main(String[] args) {

        DocumentFactory wordFactory = new WordDocumentFactory();
        IDocument wordDoc = wordFactory.createDocument();
        wordDoc.open();

        DocumentFactory pdfFactory = new PdfDocumentFactory();
        IDocument pdfDoc = pdfFactory.createDocument();
        pdfDoc.open();

        DocumentFactory excelFactory = new ExcelDocumentFactory();
        IDocument excelDoc = excelFactory.createDocument();
        excelDoc.open();
    }
}
