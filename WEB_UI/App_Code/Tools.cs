using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

/// <summary>
/// © copyright reserved , shadi fadila 2019 
/// </summary>
public class Tools
{
    public Tools()
    {
        //
        // TODO: Add constructor logic here
        //

    }
    static public string gensym(string ext, int id)
    {
        string sym_name = (DateTime.Now.ToString() + id.ToString() + "." + ext).ToString().Trim().Replace(" ", "").Replace(":", "").Replace("/", "");
        return sym_name;
    }

    static public string gensym(string ext)
    {
        string sym_name = (DateTime.Now.ToString() + "1." + ext).ToString().Trim().Replace(" ", "").Replace(":", "").Replace("/", "");
        return sym_name;
    }
    public static Bitmap ResizeImage(Image image, int width, int height)
    {
        var destRect = new Rectangle(0, 0, width, height);
        var destImage = new Bitmap(width, height);

        destImage.SetResolution(image.HorizontalResolution, image.VerticalResolution);

        using (var graphics = Graphics.FromImage(destImage))
        {
            graphics.CompositingMode = CompositingMode.SourceCopy;
            graphics.CompositingQuality = CompositingQuality.HighSpeed;
            graphics.InterpolationMode = InterpolationMode.Low;
            graphics.SmoothingMode = SmoothingMode.HighSpeed;
            graphics.PixelOffsetMode = PixelOffsetMode.HighSpeed;

            using (var wrapMode = new ImageAttributes())
            {
                wrapMode.SetWrapMode(WrapMode.TileFlipXY);
                graphics.DrawImage(image, destRect, 0, 0, image.Width, image.Height, GraphicsUnit.Pixel, wrapMode);
            }
        }

        return destImage;
    }


    public static bool USERNAME_VALIDATOR(string username)
    {
        string pattern;
        // start with a letter, allow letter or number, length between 6 to 12.
        pattern = "^[a-zA-Z][a-zA-Z0-9]{4,11}";
        Regex regex = new Regex(pattern);
        if (regex.IsMatch(username) && checkForSQLInjection(username)==false)
            return true;
        return false;
    }

    public static Boolean checkForSQLInjection(string userInput)
    {
        bool isSQLInjection = false;
        string[] sqlCheckList = { "--",
                                       ";--",
                                       ";",
                                       "/*",
                                       "*/",
                                        "@@",
                                        "@",
                                        "char",
                                       "nchar",
                                       "varchar",
                                       "nvarchar",
                                       "alter",
                                       "begin",
                                       "cast",
                                       "create",
                                       "cursor",
                                       "declare",
                                       "delete",
                                       "drop",
                                       "end",
                                       "exec",
                                       "execute",
                                       "fetch",
                                            "insert",
                                          "kill",
                                             "select",
                                           "sys",
                                            "sysobjects",
                                            "syscolumns",
                                           "table",
                                           "update"
        };
        string CheckString = userInput.Replace("'", "''");
        for (int i = 0; i <= sqlCheckList.Length - 1; i++)
        {
            if ((CheckString.IndexOf(sqlCheckList[i], StringComparison.OrdinalIgnoreCase) >= 0))
                isSQLInjection = true;
        }
        return isSQLInjection;
    }


public static void ResizeImageWidth(int size, string filePath, string saveFilePath)
    {
        //variables for image dimension/scale
        double newHeight = 0;
        double newWidth = 0;
        double scale = 0;

        //create new image object
        Bitmap curImage = new Bitmap(filePath);

        scale = Convert.ToSingle(size) / curImage.Width;
        //}
        if (scale < 0 || scale > 1) { scale = 1; }

        //New image dimension
        newHeight = Math.Floor(Convert.ToSingle(curImage.Height) * scale);
        newWidth = Math.Floor(Convert.ToSingle(curImage.Width) * scale);

        //Create new object image
        Bitmap newImage = new Bitmap(curImage, Convert.ToInt32(newWidth), Convert.ToInt32(newHeight));
        Graphics imgDest = Graphics.FromImage(newImage);
        imgDest.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
        imgDest.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
        imgDest.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
        imgDest.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
        ImageCodecInfo[] info = ImageCodecInfo.GetImageEncoders();
        EncoderParameters param = new EncoderParameters(1);
        param.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);

        //Draw the object image
        imgDest.DrawImage(curImage, 0, 0, newImage.Width, newImage.Height);

        //Save image file
        newImage.Save(saveFilePath, info[1], param);

        //Dispose the image objects
        curImage.Dispose();
        newImage.Dispose();
        imgDest.Dispose();
    }


}