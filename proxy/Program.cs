using HtmlAgilityPack;
using System;
using System.IO;
using System.Linq;
using System.Net;

namespace proxy
{
    class Program
    {
        static void Main(string[] args)
        {
            HttpListener listener = new HttpListener();
            listener.Prefixes.Add("http://localhost:8080/");
            listener.Start();
            
            HttpListenerContext context = listener.GetContext();
            
            HttpListenerRequest request = context.Request;
            HttpListenerResponse response = context.Response;            

            
            HttpWebRequest request1 = (HttpWebRequest)WebRequest.Create("http://www.reddit.com"+request.RawUrl);//
            request1.Method = "Get";
            request1.KeepAlive = true;
            request1.ContentType = "appication/json";
            request1.Headers.Add("Content-Type", "appication/json");
            

            HttpWebResponse response1 = (HttpWebResponse)request1.GetResponse();            

            foreach (string header in response1.Headers)
            {
                response.Headers[header] = response1.Headers[header];
            }
            
            var content = "";
            using (var reader = new StreamReader(response1.GetResponseStream()))
            {
                content = reader.ReadToEnd();
            }

            var document = new HtmlDocument();
            document.LoadHtml(content);

            TraverseAndChange(document.DocumentNode.SelectSingleNode("//body"));


            document.Save(response.OutputStream);
            
            response.Close();
        }

        public static void TraverseAndChange(HtmlNode node)
        {
            if (!string.IsNullOrEmpty(node.InnerText))
            {
                var arr = node.InnerText.Split(' ').Select(word => word.Length == 6 ? word + "&#8482;" : word);
                var updatedText = string.Join(' ', arr);
                node.InnerText = updatedText;
            }
            if (node.InnerHtml.Contains("reddit.com"))
            {
                node.InnerHtml = node.InnerHtml.Replace("reddit.com", "localhost:8080");
            }

            foreach(var child in node.ChildNodes)
            {
                TraverseAndChange(child);
            }
        }
    }
}
