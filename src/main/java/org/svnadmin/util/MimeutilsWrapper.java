package org.svnadmin.util;

import java.io.File;
import java.util.Collection;

import eu.medsea.mimeutil.MimeUtil;

public class MimeutilsWrapper {
	static {
		File mimefile;
		String currentmimefile = (String) System.getProperties().get("magic-mime");
		if (currentmimefile != null) {
			if (currentmimefile.equals("") == false) {
				mimefile = new File(currentmimefile);
				if (mimefile.exists() == false) {
					mimefile = new File("magic.mime");
					if (mimefile.exists()) {
						System.getProperties().put("magic-mime", mimefile.getPath());
					}
				}
			}
		}
		MimeUtil.registerMimeDetector("eu.medsea.mimeutil.detector.MagicMimeMimeDetector");
		MimeUtil.registerMimeDetector("eu.medsea.mimeutil.detector.ExtensionMimeDetector");
		MimeUtil.registerMimeDetector("eu.medsea.mimeutil.detector.WindowsRegistryMimeDetector");
		// MimeUtil.registerMimeDetector("eu.medsea.mimeutil.detector.OpendesktopMimeDetector");
	}

	public static String getMime(String fileName) {
		try {
			Collection<?> mimeTypes = MimeUtil.getMimeTypes(fileName);
			return String.valueOf(mimeTypes);
		} catch (Exception e) {
			e.printStackTrace();
			return "application/octet-streamA";
		}
	}
}
