public static void BurnInLightmapUV(List<Mesh> meshes)
{
	for (int x = 0; x < meshes.Count; x++)
	{
		Renderer rend = meshes[x].GetComponent<Renderer>();
		if (rend != null)
		{
			Vector4 lightmapScaleOffset = rend.lightmapScaleOffset;
			if (lightmapScaleOffset != Vector4.zero) 
			{
				Mesh mesh = meshes[x].sharedMesh;
				Vector2[] uvs = mesh.uv2;

				for (int y = 0; y < uvs.Length; y++) 
				{
					Vector2 uv = uvs[y];
					uv.x *= lightmapScaleOffset.x;
					uv.y *= lightmapScaleOffset.y;

					uv.x += lightmapScaleOffset.z;
					uv.y += lightmapScaleOffset.w;
					uvs[y] = uv;
				}
				mesh.uv2 = uvs;
				meshes[x].sharedMesh = newMesh;
				rend.lightmapScaleOffset = new Vector4(1.0f, 1.0f, 0.0f, 0.0f);
			}
		}
	}
}