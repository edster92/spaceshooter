using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WeaponLaser : BaseWeapon
{
	
	[SerializeField]
	LineRenderer laserBeam;
	[SerializeField]
	ParticleSystem impactParticle;


	public override void FireStart ()
	{

		laserBeam.gameObject.SetActive (true);
		base.FireStart ();
	}

	protected override IEnumerator Fire ()
	{
	//	Transform pos = levelAnchors [0].ShotAnchors[0]; 	
		while (fireOn) {
			RaycastHit hit;
			if (Physics.Raycast (laserBeam.transform.position, laserBeam.transform.forward, out hit, 150)) 
			{
				laserBeam.SetPosition (1, (hit.point.z - laserBeam.transform.position.z) * Vector3.forward);
				hit.collider.gameObject.GetComponent<BasedGameObjects> ().AddedGamage (damage [WeaponLevel - 1] * Time.deltaTime);
				impactParticle.transform.position = laserBeam.transform.position + laserBeam.GetPosition (1);
				if (!impactParticle.isPlaying)
					impactParticle.Play (true);
			} 
			else 
			{
				laserBeam.SetPosition (1, 150 * Vector3.forward);
				impactParticle.Stop ();
			}
			yield return null;
		}
	}
	public override void FireEnd ()
	{
		base.FireEnd ();
		laserBeam.gameObject.SetActive (false);
		impactParticle.Stop ();
	}
}
