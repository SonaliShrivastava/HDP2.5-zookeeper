### Licensed to the Apache Software Foundation (ASF) under one or more
### contributor license agreements.  See the NOTICE file distributed with
### this work for additional information regarding copyright ownership.
### The ASF licenses this file to You under the Apache License, Version 2.0
### (the "License"); you may not use this file except in compliance with
### the License.  You may obtain a copy of the License at
###
###     http://www.apache.org/licenses/LICENSE-2.0
###
### Unless required by applicable law or agreed to in writing, software
### distributed under the License is distributed on an "AS IS" BASIS,
### WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
### See the License for the specific language governing permissions and
### limitations under the License.

function Main( $scriptDir )
{
    $FinalName = "zookeeper-@version@"
    $HDP_INSTALL_PATH, $HDP_RESOURCES_DIR = Initialize-InstallationEnv $scriptDir "$FinalName.winpkg.log"
    $nodeInstallRoot = "$ENV:HADOOP_NODE_INSTALL_ROOT"

    Write-Log "Uninstalling Apache Zookeeper"
    
    Uninstall "zookeeper" $nodeInstallRoot

    Write-Log "Uninstall of Zookeeper completed successfully"
}

try
{
    $scriptDir = Resolve-Path (Split-Path $MyInvocation.MyCommand.Path)
    $utilsModule = Import-Module -Name "$scriptDir\..\resources\Winpkg.Utils.psm1" -ArgumentList ("ZOOKEEPER") -PassThru
    $apiModule = Import-Module -Name "$scriptDir\InstallApi.psm1" -PassThru
    Main $scriptDir
}
catch
{
    Write-Log $_.Exception.Message "Failure" $_
    Write-Log "Continuing anyways..."
}
finally
{
    if( $utilsModule -ne $null )
    {
        Remove-Module $apiModule
        Remove-Module $utilsModule
    }
}