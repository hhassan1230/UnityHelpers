// sort renderers by material / mesh
Renderer[] renderers = FindObjectsOfType(typeof(Renderer)) as Renderer[];
for (int x = 0; x < renderers.Length; x++)
{
	Renderer rend = renderers[x];
	int id = 0;

	if (rend != null && rend.sharedMaterial != null)
	{
		int materialId = rend.sharedMaterial.GetInstanceID();
		id = 0xFF & materialId;
	}

	rend.sortingOrder = id;
}