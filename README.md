# Userland
Collection of android userland tools

## Docker 
1. chmod +x install_docker_userland.sh
2. ./install_docker_userland.sh

const { OPCUAClient, AttributeIds, resolveNodeId } = require("node-opcua");

const endpointUrl = "opc.tcp://localhost:4840"; // Deinen Server anpassen
const rootNodeId = "RootFolder"; // Oder ein beliebiger anderer NodeId, z. B. "ns=1;i=1001"

async function main() {
    const client = OPCUAClient.create({ endpointMustExist: false });

    try {
        await client.connect(endpointUrl);
        console.log("Verbunden mit", endpointUrl);

        const session = await client.createSession();
        console.log("Session erstellt");

        const rootNode = resolveNodeId(rootNodeId);

        await browseRecursive(session, rootNode, 0);

        await session.close();
        await client.disconnect();
        console.log("Verbindung beendet");

    } catch (err) {
        console.error("Fehler:", err);
    }
}

async function browseRecursive(session, nodeId, indentLevel) {
    const indent = "  ".repeat(indentLevel);
    const nodeToBrowse = {
        nodeId: nodeId,
        referenceTypeId: "HierarchicalReferences",
        includeSubtypes: true,
        browseDirection: 0,
        resultMask: 63
    };

    const result = await session.browse(nodeToBrowse);

    for (const reference of result.references) {
        console.log(`${indent}- ${reference.browseName.name} (${reference.nodeId.toString()})`);
        await browseRecursive(session, reference.nodeId, indentLevel + 1);
    }
}

main();