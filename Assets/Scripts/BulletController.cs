using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BulletController : BasedGameObjects {

	public float BulletDamage = 1;
	[SerializeField]
	ParticleSystem impactEffect = null;
    public override void Initialized()
    {
        Type = Types.bulet;

    }
    public override void Death()
    {
        Destroy(gameObject);
    }
    public override void Impact(BasedGameObjects objectImpact)
    {
		objectImpact.AddedGamage (BulletDamage);
		if (impactEffect) {
			Instantiate (impactEffect, transform.position, Quaternion.identity);
		}
		Death ();
    }
}
