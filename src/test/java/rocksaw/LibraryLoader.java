package rocksaw;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;

public class LibraryLoader {
	public void loadLibrary(String libname) throws IOException {
		String tmpDir = System.getProperty("java.io.tmpdir");
		URL classPathUrl = getClass().getResource(String.format("/%s", libname));
		if (classPathUrl == null) { throw new RuntimeException("Could not locate library in classpath."); }
		
		File embeddedFile = new File(classPathUrl.getFile());
		if (embeddedFile.exists() && embeddedFile.canRead()) {
			File exportedLib = new File(tmpDir, libname);
			
			BufferedInputStream bIn = null;
			BufferedOutputStream bOut = null;
			try {
				bIn = new BufferedInputStream(new FileInputStream(embeddedFile));
				bOut = new BufferedOutputStream(new FileOutputStream(exportedLib));
				
				int b;
				while ((b = bIn.read()) != -1) {
					bOut.write(b);
				}
			} finally {
				if (bOut != null) {
					bOut.flush();
					bOut.close();
				}
				
				if (bIn != null) {
					bIn.close();
				}
			}
			
			Runtime.getRuntime().load(exportedLib.getAbsolutePath());
		}
	}
}