﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Newtonsoft.Json;

namespace DevAudit.AuditLibrary
{
    /*
    [
      {
        "coordinates": "bower:jquery@1.9.0",
        "description": "jQuery JavaScript Library",
        "reference": "https://ossindex.sonatype.org/component/bower:jquery@1.9.0",
        "vulnerabilities": [
          {
            "id": "49da4413-af2b-4e55-acc0-9c752e30dde4",
            "title": "CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')",
            "description": "The software does not neutralize or incorrectly neutralizes user-controllable input before it is placed in output that is used as a web page that is served to other users.",
            "cvssScore": 7.2,
            "cvssVector": "CVSS:3.0/AV:N/AC:L/PR:N/UI:N/S:C/C:L/I:L/A:N",
            "cwe": "CWE-79",
            "reference": "https://ossindex.sonatype.org/vuln/49da4413-af2b-4e55-acc0-9c752e30dde4"
          },
          {
            "id": "52f593c8-7729-435c-b9df-a7bb9ded8589",
            "title": "CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')",
            "description": "The software does not neutralize or incorrectly neutralizes user-controllable input before it is placed in output that is used as a web page that is served to other users.",
            "cvssScore": 6.1,
            "cvssVector": "CVSS:3.0/AV:N/AC:L/PR:N/UI:R/S:C/C:L/I:L/A:N",
            "cwe": "CWE-79",
            "reference": "https://ossindex.sonatype.org/vuln/52f593c8-7729-435c-b9df-a7bb9ded8589"
          },
          {
            "id": "3b3ba2f8-9c2c-4afe-b593-75c6b3fd4bb7",
            "title": "[CVE-2015-9251] jQuery before 3.0.0 is vulnerable to Cross-site Scripting (XSS) attacks when a c...",
            "description": "jQuery before 3.0.0 is vulnerable to Cross-site Scripting (XSS) attacks when a cross-domain Ajax request is performed without the dataType option, causing text/javascript responses to be executed.",
            "cvssScore": 6.1,
            "cvssVector": "CVSS:3.0/AV:N/AC:L/PR:N/UI:R/S:C/C:L/I:L/A:N",
            "reference": "https://ossindex.sonatype.org/vuln/3b3ba2f8-9c2c-4afe-b593-75c6b3fd4bb7"
          }
        ]
      }
    ] */
    public class OSSIndexApiv3Package
    {
        [JsonProperty("coordinates")]
        public string Coordinates { get; set; }

        [JsonProperty("description")]
        public string Description { get; set; }

        [JsonProperty("reference")]
        public string Reference { get; set; }

        [JsonProperty("vulnerabilities")]
        public List<OSSIndexApiv3Vulnerability> Vulnerabilities { get; set; }

        [JsonIgnore]
        public string PackageId { get; set; }

        [JsonIgnore]
        public Package Package { get; set; }

        [JsonIgnore]
        public bool CurrentPackageVersionIsInRange { get; set; }
    }

}
