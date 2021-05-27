/*  Copyright (C) 2021 Maik Merten

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

    See file, 'COPYING', for details.
*/

// This is a primitive something to extract QUAKED comments from QuakeC-files

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

public class QDefExtractor {


    private static void writeDefsFile(StringBuilder sb, File deffile) throws Exception {
        byte[] defsBytes = sb.toString().getBytes(Charset.forName("UTF8"));
        try(FileOutputStream fos = new FileOutputStream(deffile)) {
            fos.write(defsBytes);
        }
    }


    private static int extractQuakedComments(File f, StringBuilder sb) throws Exception {
        int count = 0;

        try(BufferedReader br = new BufferedReader(new FileReader(f))) {
            String line;
            boolean inComment = false;
            while((line = br.readLine()) != null) {
                if(line.trim().startsWith("/*QUAKED")) {
                    inComment = true;
                    count++;
                }

                if(inComment) {
                    sb.append(line);
                    sb.append("\n");
                }

                if(line.trim().endsWith("*/")) {
                    if(inComment) {
                        // add another newline after end of enity QUAKED comment
                        sb.append("\n");
                    }
                    inComment = false;
                }
            }
        }
        return count;
    }

    private static List<File> readProgsSrc(String progssrc) throws Exception {
        List<File> filelist = new ArrayList<>();

        try(BufferedReader br = new BufferedReader(new FileReader(progssrc))) {
            String line;
            while((line = br.readLine()) != null) {
                line = line.trim();
                if(line.length() > 0) {
                    String[] parts = line.split("\\s+"); // split by any whitespace
                    if(parts.length > 0) {
                        String filename = parts[0];
                        if(filename.endsWith(".qc") || filename.endsWith(".qh")) {
                            filelist.add(new File(filename));
                        }
                    }
                }
            }

        }
        return filelist;
    }


    public static void main(String[] args) throws Exception {
        if(args.length != 2) {
            System.out.println("usage: QDefExtractor <progs.src> <output.def>");
            System.exit(1);
        }

        String progssrc = args[0];
        String output = args[1];
        StringBuilder sb = new StringBuilder();


        int entityCount = 0;
        List<File> srcfiles = readProgsSrc(progssrc);
        for(File f : srcfiles) {
            entityCount += extractQuakedComments(f, sb);
        }

        writeDefsFile(sb, new File(output));

        System.out.println("Found " + entityCount + " entities in " + srcfiles.size() + " QuakeC input files");
    }
}