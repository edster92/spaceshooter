﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : BasedGameObjects
{

    public GameObject ExploisionPartickle;
    [SerializeField]
    float immortalTime;
    public ParticleSystem ImmortalVisualParticle;
    private float timeBeforKick;
    float currentXposition;
    public Animator anim;
    [SerializeField]
    private float mergeAnimationSpeed;
    public static PlayerController instance;
	public BaseWeapon Weapon;
	[SerializeField]
	UIprogressBar progressBar;

	float immortalityTime;

	public override float HealthPoints
	{
		get { return healthPoints; }
		set { healthPoints = value;
			Done_GameController.Instance.UpdateHealth (value);
			if (healthPoints <= 0) {
				Done_GameController.Instance.GameOver ();
				Death ();
			}
		}
	}

    void Awake()
    {
        PlayerController.instance = this;
    }

    void Update ()
    {
		if (Input.GetMouseButtonDown (0) || Input.GetKeyDown (KeyCode.Space))
			Weapon.FireStart ();
		if (Input.GetMouseButtonUp (0) || Input.GetKeyUp (KeyCode.Space))
			Weapon.FireEnd ();
		

        float currentMoveVector = anim.GetFloat("MoveVector");

        if (Input.GetKey(KeyCode.RightArrow))
        {
            currentXposition = Mathf.Clamp(currentXposition + (moveSpeedX * Time.deltaTime), Done_GameController.Instance.Xmin, Done_GameController.Instance.Xmax);
            anim.SetFloat("MoveVector", Mathf.Clamp (currentMoveVector + (mergeAnimationSpeed * Time.deltaTime),-1,1));
        }
        else if (Input.GetKey(KeyCode.LeftArrow))
        {
            currentXposition = Mathf.Clamp(currentXposition - (moveSpeedX * Time.deltaTime), Done_GameController.Instance.Xmin, Done_GameController.Instance.Xmax);
            anim.SetFloat("MoveVector", Mathf.Clamp(currentMoveVector - (mergeAnimationSpeed * Time.deltaTime), -1, 1));
        }
        else
        {
            anim.SetFloat("MoveVector", currentMoveVector - (Mathf.Abs(currentMoveVector) > (mergeAnimationSpeed * Time.deltaTime) ?
                (mergeAnimationSpeed * Time.deltaTime * Mathf.Sign(currentMoveVector)) : currentMoveVector));
        }
        transform.localPosition = new Vector3 (currentXposition, transform.localPosition.y, transform.localPosition.z);

    }

    public override void Initialized()
    {
        Type = Types.player;
		Done_GameController.Instance.UpdateHealth (HealthPoints);
    }
    public override void Death()
    {
        Instantiate(ExploisionPartickle, transform.position, Quaternion.identity);
        Done_GameController.Instance.GameOver();
        Destroy(gameObject);
    }
	public override void AddedGamage (float Damage)
    {
		
        if (Time.time >= timeBeforKick)
        {
			HealthPoints -= Damage;
			if (HealthPoints > 0)
				AddImmoratl(immortalTime);
        }
    }
    public void AddImmoratl (float TimeForImmortal)
    {
		if (Time.time < immortalTime) {
			immortalityTime = TimeForImmortal;
			timeBeforKick += TimeForImmortal;
		}
        else
        {
			immortalityTime = TimeForImmortal;
            timeBeforKick = Time.time + TimeForImmortal;
            StartCoroutine(ImmortalVisual());
        }
    }
    public IEnumerator ImmortalVisual ()
    {
        ImmortalVisualParticle.Play(true);
		progressBar.icon.SetActive(true);
		while (Time.time < timeBeforKick) {
			progressBar.CurrentValue = (timeBeforKick - Time.time) / immortalityTime;
			yield return null;
		}
		progressBar.CurrentValue = 0;
        ImmortalVisualParticle.Stop(true, ParticleSystemStopBehavior.StopEmitting);
		progressBar.icon.SetActive (false);
    }
}
