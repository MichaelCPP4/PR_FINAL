using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HorizontalList
{
    partial class SkladEntities
    {
        private static SkladEntities context;

        public static SkladEntities GetContext()
        {
            if (context == null)
                context= new SkladEntities();
                return context;
        }
    }
}
